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
1. Linealidad Yi = alpha + B Xi + ui
2. ~~X no aleatoria: las Xi son deterministicas ~~  (No importnate)
	1. Los valores no son aleatorios. Ej: si hago una encuesta en el secundario, las edades van a ser entre 12 y 18, no va a ser aleatorio. Vs No se cuanto va a ser el PBI de un pais.
3. Esperanza nula de ui (exogeneidad): E(ui) = 0
	1. En promedio, los errores de las observaciones se cancelan entre si. Los errores no me generan un sesgo.
4. Homocedasticidad: si crecen los valores en el eje x, crecen los valores en el eje y. 
	1. Hay una dispersion de los datos y es constante. ![[Pasted image 20261002092423.png]]
5. No correlacion serial: Cov(ui, uj) = 0
	1. No hay relación entre los errores de las personas entre si. son independientes.
	2. Pasa mucho en series de tiempos.
6. Si hay dos variables colineales, elimino una.
    - Colinealidad: que una variable depende linealmente de la otra. Ej: algo que se mide en dos unidades distintas
    - No te sirve de nada porque no voy a tener nada de variabilidad.

# Clase 7
## Propiedades estadisticas
- No son demostrables, estan apoyadas en los supuestos clasicos

* Insesgadez
	- Def: Sea β^ un estimador de β, decimos que es insesgado si E(β^) = β
	- Si puedo calcular infinitos β^, estan centrados en el verdadero valor del parametro. En promedio le pega al verdadero valor del parametro.
	- se cumple solo si se cumple la exogeneidad: los errores no afectan al calculo del β^
- Varianza de β^
	- mientras mayor sea la varianza de los errores, mas grande la varianza del β^
	- mientras mas variabilidad tengo, menor la varianza del β^. Ej: si quiero saber el salario es mejor tener gente de muchas edades.
	- Mayor n, menos varianza del β^. Mayor variabilidad/varianza en las X, mas preciso mi estimación del β que relaciona el X con Y.
- Teorema de Gauss-Markov
	- El estimador de MCO es el mejor estimador lineal e insesgado.
		- Mejor != Bueno. Pero es el mejor (que menos variabilidad) tiene.

Bondad de ajuste:
- Cuanto (en porcentaje) X explica Y.
- Se mide con el R2
- Hay variabilidad que podemos explicar (la que agarra el modelo/metodo) y la que no.
	- Ej: La variabilidad de salarios hay una parte que voy a explicar con los años de educacion y una parte que no: contactos, disponibilidad horaria para trabajar, etc.

Test de significancia individual
- Hipotesis: H0: B = 0 y H1: B != 0
- Si se cumple H0, X no explica a Y. 

### Ejemplo
- inf_i = alpha + beta * open_i + mu_i
- Intercepto es el alpha
	- Puedo interpretar el alpha SOLO cuando open_i = 0.

## El modelo con k variables
- Saco cosas del termino de error y las meto en una de las variables.
	- Y no solo depende de X, sino de X_1, X_2, ..., X_k.
- Agregamos muchas variables explicativas: Y_i = B_0 + B_1 X_1_i + B_2 X_2_i + ... + B_k X_k_i
- Puede haber colinealidad entre las X_i pero no puede ser perfecta.
- E(Y_i) = ... => B_k mide el cambio de E(Y_i) cuando X_k aumenta en una unidad manteniendo constante las demas variables

Variables binarias significativas:
- Metemos una variable binaria (dummy) que vale 1 si esta presente y 0 si no.
	- Ejemplo: democ_A_i = 1 si A es democrata, 0 si es republicano
- 0 es la categoria base

Interaccion
- no me genera otra ordenada al origen sino que cambia la pendiente de la recta
- lo usas cuando pensas que hay una variable que no afecta igual a los dos grupos