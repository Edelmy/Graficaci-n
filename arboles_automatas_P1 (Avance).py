import ply.lex as lex
import ply.yacc as yacc

# ==========================================
# 1. ANALIZADOR LÉXICO (LEX)
# ==========================================
tokens = (
    'REVALUAR', 'PARIZQ', 'PARDER', 'CORIZQ', 'CORDER',
    'MAS', 'MENOS', 'POR', 'DIVIDIDO', 'POTENCIA', 'XOR',
    'IGUAL', 'IDENTIFICADOR', 'DECIMAL', 'ENTERO', 'PTCOMA'
)

# Palabras reservadas: se resuelven dentro de t_IDENTIFICADOR
# (evita que "XOR" sea reconocido como variable en vez de operador)
reserved = {
    'XOR': 'XOR',
}

t_REVALUAR    = r'Evaluar'
t_PARIZQ      = r'\('
t_PARDER      = r'\)'
t_CORIZQ      = r'\['
t_CORDER      = r'\]'
t_MAS         = r'\+'
t_MENOS       = r'-'
t_POR         = r'\*'
t_DIVIDIDO    = r'/'
t_POTENCIA    = r'\^'
t_IGUAL       = r'='
t_PTCOMA      = r';'

def t_DECIMAL(t):
    r'\d+\.\d+'
    t.value = float(t.value)
    return t

def t_ENTERO(t):
    r'\d+'
    t.value = int(t.value)
    return t

def t_IDENTIFICADOR(t):
    r'[a-zA-Z_][a-zA-Z0-9_]*'
    t.type = reserved.get(t.value, 'IDENTIFICADOR')
    return t

t_ignore = " \t\r"

def t_newline(t):
    r'\n+'
    t.lexer.lineno += t.value.count("\n")

def t_error(t):
    print(f"Caracter ilegal: '{t.value[0]}'")
    t.lexer.skip(1)

lexer = lex.lex()

# ==========================================
# 2. ANALIZADOR SINTÁCTICO (YACC) Y ÁRBOLES
# ==========================================

class ASTNode:
    def __init__(self, value, children=None):
        self.value = value
        self.children = children if children else []

    def display(self, indent="", is_last=True):
        marker = "└── " if is_last else "├── "
        print(indent + marker + str(self.value))
        indent += "    " if is_last else "│   "
        for i, child in enumerate(self.children):
            if isinstance(child, ASTNode):
                child.display(indent, i == len(self.children) - 1)
            else:
                print(indent + ("└── " if i == len(self.children) - 1 else "├── ") + str(child))

# Precedencia de Operadores
precedence = (
    ('left', 'XOR'),
    ('left', 'MAS', 'MENOS'),
    ('left', 'POR', 'DIVIDIDO'),
    ('right', 'POTENCIA'),
    ('right', 'UMENOS'),
)

variables = {}
reglas_aplicadas = []

# ---------------------------------------------------------
# Tabla de reglas (nombradas con letras):
#   A -> expresion : ENTERO | DECIMAL         (número)
#   B -> expresion : IDENTIFICADOR             (variable)
#   C -> expresion : ( expresion )             (agrupación)
#   D -> expresion : - expresion               (negativo)
#   E -> expresion : expresion (+|-|*|/|^) expresion   (binaria aritmética)
#   F -> expresion : expresion XOR expresion   (binaria XOR)
#   G -> instruccion : IDENTIFICADOR = expresion       (asignación)
#   H -> instruccion : expresion               (expresión suelta)
#   I -> instruccion : REVALUAR [ expresion ]  (evaluar/depurar)
# ---------------------------------------------------------

def p_instrucciones_lista(t):
    '''instrucciones : instruccion instrucciones
                     | instruccion'''
    if len(t) == 3:
        t[0] = [t[1]] + t[2]
    else:
        t[0] = [t[1]]

def p_instruccion_evaluar(t):
    'instruccion : REVALUAR CORIZQ expresion CORDER'
    val, arbol_expr, arbol_sint = t[3]
    reglas_aplicadas.append("I: instruccion -> REVALUAR [ expresion ]")
    t[0] = (val, arbol_expr, ASTNode("I", [
        ASTNode("REVALUAR"), ASTNode("CORIZQ"), arbol_sint, ASTNode("CORDER")
    ]))

def p_instruccion_asignacion(t):
    'instruccion : IDENTIFICADOR IGUAL expresion'
    val, arbol_expr, arbol_sint = t[3]
    variables[t[1]] = val
    reglas_aplicadas.append(f"G: instruccion -> {t[1]} = expresion")

    nuevo_arbol_expr = ASTNode(f"Asignacion ({t[1]})", [ASTNode("="), arbol_expr])
    nuevo_arbol_sint = ASTNode("G", [
        ASTNode(t[1]), ASTNode("IGUAL"), arbol_sint
    ])
    t[0] = (val, nuevo_arbol_expr, nuevo_arbol_sint)

def p_instruccion_expresion(t):
    'instruccion : expresion'
    val, arbol_expr, arbol_sint = t[1]
    reglas_aplicadas.append("H: instruccion -> expresion")
    t[0] = (val, arbol_expr, arbol_sint)

def p_expresion_binaria(t):
    '''expresion : expresion MAS expresion
                 | expresion MENOS expresion
                 | expresion POR expresion
                 | expresion DIVIDIDO expresion
                 | expresion POTENCIA expresion
                 | expresion XOR expresion'''
    op = t[2]
    val1, arbol_expr1, arbol_sint1 = t[1]
    val2, arbol_expr2, arbol_sint2 = t[3]

    if op == '+': res = val1 + val2
    elif op == '-': res = val1 - val2
    elif op == '*': res = val1 * val2
    elif op == '/': res = val1 / val2
    elif op == '^': res = val1 ** val2
    elif op == 'XOR': res = int(val1) ^ int(val2)

    letra = "F" if op == 'XOR' else "E"
    reglas_aplicadas.append(f"{letra}: expresion -> expresion {op} expresion")

    # Árbol de expresión: solo el operador con sus dos operandos
    arbol_expr = ASTNode(f"Operacion ({op})", [arbol_expr1, arbol_expr2])

    # Árbol sintáctico: refleja la regla gramatical completa
    arbol_sint = ASTNode(letra,
                          [arbol_sint1, ASTNode(op), arbol_sint2])

    t[0] = (res, arbol_expr, arbol_sint)

def p_expresion_unaria(t):
    'expresion : MENOS expresion %prec UMENOS'
    val, arbol_expr, arbol_sint = t[2]
    reglas_aplicadas.append("D: expresion -> - expresion")

    nuevo_arbol_expr = ASTNode("Unario (-)", [arbol_expr])
    nuevo_arbol_sint = ASTNode("D", [ASTNode("MENOS"), arbol_sint])

    t[0] = (-val, nuevo_arbol_expr, nuevo_arbol_sint)

def p_expresion_agrupacion(t):
    'expresion : PARIZQ expresion PARDER'
    val, arbol_expr, arbol_sint = t[2]
    reglas_aplicadas.append("C: expresion -> ( expresion )")

    # En el árbol de expresión los paréntesis no generan nodo propio
    # (ya quedan implícitos en la forma del árbol)
    nuevo_arbol_expr = ASTNode("Agrupacion ()", [arbol_expr])

    # En el árbol sintáctico sí se conservan literalmente
    nuevo_arbol_sint = ASTNode("C", [
        ASTNode("PARIZQ"), arbol_sint, ASTNode("PARDER")
    ])

    t[0] = (val, nuevo_arbol_expr, nuevo_arbol_sint)

def p_expresion_numero(t):
    '''expresion : ENTERO
                 | DECIMAL'''
    reglas_aplicadas.append(f"A: expresion -> {t[1]}")

    arbol_expr = ASTNode(f"Num({t[1]})")
    arbol_sint = ASTNode("A", [ASTNode(t.slice[1].type), ASTNode(str(t[1]))])

    t[0] = (t[1], arbol_expr, arbol_sint)

def p_expresion_id(t):
    'expresion : IDENTIFICADOR'
    val = variables.get(t[1], 0)
    reglas_aplicadas.append(f"B: expresion -> {t[1]}")

    arbol_expr = ASTNode(f"Var({t[1]})")
    arbol_sint = ASTNode("B", [ASTNode("IDENTIFICADOR"), ASTNode(t[1])])

    t[0] = (val, arbol_expr, arbol_sint)

def p_error(t):
    if t:
        print(f"Error sintáctico en '{t.value}'")
    else:
        print("Error sintáctico al final de la entrada")

parser = yacc.yacc()

# ==========================================
# 3. BUCLE DE LECTURA TECLADO Y EJECUCIÓN
# ==========================================
if __name__ == '__main__':
    print("=== PROCESADOR DE EXPRESIONES ARITMÉTICAS ===")
    print("Escriba la función a evaluar (o 'salir' para finalizar):")

    while True:
        try:
            s = input('\nEntrada > ')
        except EOFError:
            break
        if not s or s.lower() == 'salir':
            break

        reglas_aplicadas.clear()
        result = parser.parse(s)

        if result:
            print("\n--- RESULTADOS ---")
            for res_val, arbol_expr, arbol_sint in result:
                print(f"Respuesta Final: {res_val}")

                print("\n[Tabla de Reglas Aplicadas]")
                for r in reglas_aplicadas:
                    print(f"  └─ {r}")

                print("\n[Árbol de Expresión]")
                arbol_expr.display()

                print("\n[Árbol Sintáctico]")
                arbol_sint.display()