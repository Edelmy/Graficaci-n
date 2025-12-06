#Código para insertar 10, 000 datos en la base de datos de manera secuencial
#Chay Edelmy
import time
from faker import Faker
import oracledb
#Función para realizar la conexión con la base de datos
def ConnexionBD():
    conn = "localhost:1521/FREEPDB1"
    connection = oracledb.connect(
        user="prueba",
        password="1903D",
        dsn= conn, 
        #mode= "localhost:1521/FREEPDB1" #oracledb.AUTH_MODE_SYSDBA #oracledb.SYSDBA   # aquí va el modo SYSDBA
    )
    print ("conectado")
    return connection
try:
    connection = ConnexionBD() #llama a la función para abrir la conexión
    cursor = connection.cursor() #Objeto que ejecuta sql dentro de la conexión
    print("Conexión exitosa a Oracle Database")
   
    # Inicializar Faker (En español con localización en México)
    fake = Faker('es_MX')

    # Número de registros a insertar
    num = 10000
    bloque=2000 #Lo divido en bloques para evitar que los datos se ingresen de golpe
    total=0

    # Consulta para añadir datos del cliente a la BD 
    Insertar = """
    INSERT INTO CLIENTES (ID_Clientes, Nombre , Apellido_P, Apellido_M)
    VALUES (CLIENTES_SEQ.NEXTVAL, :nombre, :apellido_p, :apellido_m)
    """
    inicio= time.time()
    # Genera un for que va llenando los datos por cada vuelta por bloque en bloque
    for _ in range (1 , 2001):
        time.sleep(0.0005)  # 0.5 ms por inserción
        
        cursor.execute(
            Insertar, 
            {
            'nombre': fake.first_name(), #Los datos se llenan de manera aleatoria con datos generados por la librería Faker
            'apellido_p': fake.last_name(),
            'apellido_m': fake.last_name()
            }
        )
    connection.commit()
    print("Cambios guardados")
    fin= time.time()
    timebloque1= fin-inicio
    print(f"Bloque 1 insertado en {timebloque1:.2f} segundos")
    total+=timebloque1
    #Bloque 2
    inicio= time.time()
    for _ in range (2001,4001):
        time.sleep(0.0005)  # 0.5 ms por inserción

        cursor.execute(
            Insertar,
            {
                'nombre': fake.first_name(),
                'apellido_p': fake.last_name(),
                'apellido_m': fake.last_name()
            }
        )
    connection.commit()
    fin= time.time()
    timebloque2= fin-inicio    
    print(f"Bloque 2 insertado en {timebloque2:.2f} segundos")
    total+=timebloque2
    #Bloque 3
    inicio= time.time()
    for _ in range (4001,6001):
        time.sleep(0.0005)  # 0.5 ms por inserción

        cursor.execute(
            Insertar,
            {
                'nombre': fake.first_name(),
                'apellido_p': fake.last_name(),
                'apellido_m': fake.last_name()
            }
        )
    connection.commit()
    fin= time.time()
    timebloque3= fin-inicio
    print(f"Bloque 3 insertado en {timebloque3:.2f} segundos")
    total+=timebloque3
    #Bloque 4
    inicio= time.time()
    for _ in range (6001,8001):
        time.sleep(0.0005)  # 0.5 ms por inserción

        cursor.execute(
            Insertar,
            {
                'nombre': fake.first_name(),
                'apellido_p': fake.last_name(),
                'apellido_m': fake.last_name()
            }
        )
    connection.commit()
    fin= time.time()
    timebloque4=fin-inicio
    print(f"Bloque 4 insertado en {timebloque4:.2f} segundos")
    total+=timebloque4
     
    #Bloque 5
    inicio= time.time()
    for _ in range (8001,10001):
        time.sleep(0.0005)  # 0.5 ms por inserción

        cursor.execute(
            Insertar,
            {
                'nombre': fake.first_name(),
                'apellido_p': fake.last_name(),
                'apellido_m': fake.last_name()
            }
        )
    connection.commit()
    fin= time.time()
    timebloque5=fin-inicio
    print(f"Bloque 5 insertado en {timebloque5:.2f} segundos")
    total+=timebloque5
    
    print(f"Tiempo total acumulado: {total:.2f} segundos")
    
except Exception as e:
    print(f"Error al conectar o insertar datos: {e}")

finally: #Cierra la conexión con la base de datos
    if cursor:
        cursor.close()
    if connection:
        connection.close()
    print("Conexión cerrada.")
