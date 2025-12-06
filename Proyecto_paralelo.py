#Código para insertar 10,000 datos de clientes usando procesamiento paralelo
#Chay Edelmy
import concurrent.futures #Librería para ejecutar funciones en paralelo
import time
from faker import Faker
import oracledb

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



fake = Faker("es_MX")

    # Consulta para añadir datos del cliente
Insertar = """
    INSERT INTO CLIENTES (ID_Clientes, Nombre , Apellido_P, Apellido_M)
    VALUES (CLIENTES_SEQ.NEXTVAL, :nombre, :apellido_p, :apellido_m)
    """


#Insertar por bloques y rellenar los datos de manera aleatoria para enviarlos a la BD
def bloque_1():
    inicio = time.time() #Determina el tiempo de inicio
    conn = ConnexionBD()
    cursor = conn.cursor()

    for _ in range(1, 2001):
        time.sleep(0.0005)
        cursor.execute(Insertar, {
            "nombre": fake.first_name(),
            "apellido_p": fake.last_name(),
            "apellido_m": fake.last_name()
        })
    conn.commit() #Se guarda la información
    cursor.close()#Cierra conexión 
    conn.close()
    fin = time.time()
    return fin - inicio #Determina el tiempo de ejecución de este bloque


def bloque_2():
    inicio = time.time()
    conn = ConnexionBD()
    cursor = conn.cursor()

    for _ in range(2001, 4001):
        time.sleep(0.0005)
        cursor.execute(Insertar, {
            "nombre": fake.first_name(),
            "apellido_p": fake.last_name(),
            "apellido_m": fake.last_name()
        })
    conn.commit()
    cursor.close()
    conn.close()

    fin = time.time()
    return fin - inicio


def bloque_3():
    inicio = time.time()
    conn = ConnexionBD()
    cursor = conn.cursor()

    for _ in range(4001, 6001):
        time.sleep(0.0005)
        cursor.execute(Insertar, {
            "nombre": fake.first_name(),
            "apellido_p": fake.last_name(),
            "apellido_m": fake.last_name()
        })
    conn.commit()
    cursor.close()
    conn.close()

    fin = time.time()
    return fin - inicio


def bloque_4():
    inicio = time.time()
    conn = ConnexionBD()
    cursor = conn.cursor()

    for _ in range(6001, 8001):
        time.sleep(0.0005)
        cursor.execute(Insertar, {
            "nombre": fake.first_name(),
            "apellido_p": fake.last_name(),
            "apellido_m": fake.last_name()
        })
    conn.commit()
    cursor.close()
    conn.close()

    fin = time.time()
    return fin - inicio


def bloque_5():
    inicio = time.time()
    conn = ConnexionBD()
    cursor = conn.cursor()

    for _ in range(8001, 10001):
        time.sleep(0.0005)
        cursor.execute(Insertar, {
            "nombre": fake.first_name(),
            "apellido_p": fake.last_name(),
            "apellido_m": fake.last_name()
        })
    conn.commit()
    cursor.close()
    conn.close()

    fin = time.time()
    return fin - inicio

#Paralelo
#Se inicia el tiempo para determinar la duración total y con concurrent permite que las funciones se ejecuten de manera simultanea 
#al ser enviados al manejador de hilos
#Se asigna un bloque a un hilo independiente
iniciot= time.time()
with concurrent.futures.ThreadPoolExecutor() as executor:
    f1 = executor.submit(bloque_1)
    f2 = executor.submit(bloque_2)
    f3 = executor.submit(bloque_3)
    f4 = executor.submit(bloque_4)
    f5 = executor.submit(bloque_5)

    t1 = f1.result()
    t2 = f2.result()
    t3 = f3.result()
    t4 = f4.result()
    t5 = f5.result()

fint = time.time()
tiempo_total = fint - iniciot
print("\n Tiempos por bloques: ")
print(f"Bloque 1: {t1:.2f} s")
print(f"Bloque 2: {t2:.2f} s")
print(f"Bloque 3: {t3:.2f} s")
print(f"Bloque 4: {t4:.2f} s")
print(f"Bloque 5: {t5:.2f} s")

print(f"\nTiempo total en paralelo (multiproceso): {tiempo_total:.2f} s")