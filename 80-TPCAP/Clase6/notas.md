# Modelo
- Es una representacion simplificada de la realidad.
- Intenta resumir algo que vemos en la realidad.

- Modelo lineal: relacion lineal no exacta entre dos variables
    - Ej: Una variable es el indice de transparencia, el otro el nivel de desigualdad intentamos encontrar la relacion entre las dos.
    - Beta es lo que queremos saber. es desconocido (indice de transparencia).
    - Los Xi e Yi los conozco (es lo que se puede medir), alpha y beta no.
    - ui es nuestro error
    - por que es no exacta? porque no puedo aislar la estructura de un fenomeno en solo dos variables.

# Metodo
- Con el metodo estimo el alpha y el beta
- Intento minimizar los residuos
- ei estima ui (ei = yi - ã - b˜i, ui = yi - a - bi)

- el B˜ es la correlacion ajustada por los desvios estandares 
    - El ajuste por los desvios estandares es para darle la unidad, la correlacion tiene la fuerza pero no la unidad.
    - El B˜mide cuanto cambia E(Y) cuando cambia una unidad de X

## Supuestos clasicos
1.
2.
3.
4. Homocedasticidad: si crecen los valores en el eje x, crecen los valores en el eje y. 
5. No hay relacion entre los errores de las personas entre si. son independientes.
    - Pasa mucho en series de tiempos
6. Si hay dos variables colineales, elimino una.
    - Colinealidad: que una variable depende linealmente de la otra. Ej: algo que se mide en dos unidades distintas

