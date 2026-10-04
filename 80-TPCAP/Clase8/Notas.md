Modelo lineal:
- Y = alpha + Beta X + mu
- en el error esta todo lo inobservable (lo que no es X)
- Modelo != Metodo (modelo lineal, el metodo es MCO)
- Con el Metodo de Cuadrados ordinarios estimo el β. β^ = min ∑e_i^2
	- Insesgado: β^ le pega al verdadero valor β
	- Varianza: es el que menos varianza tiene

# Clase 8
#### Logaritmo:
- me permite interpretar B como "cuanto cambia" (elasticidad)
	- Ej: quiero ver cuanto un 1% mas de años de educacion aumenta los sueldos.

Log Log: Ejemplo exportaciones argentinas
![[Pasted image 20261003111342.png]]
- Cuando el PBI del socio aumenta en 1%, las expos argentinas aumentan un 1,238%
- Cuando la distancia aumenta en 1%, las expos argentinas disminuyen en un 1,122%

#### Modelo cuadratico
- Cuando el efecto no es constante Y SOBRE TODO: depende de donde se evalua
	- Ej: salario por años de educacion: cuando yo estudie "poco", con un año mas de educacion aumenta mucho mi salario. cuando yo estoy haciendo post-docs ya no afecta tanto.
- El efecto marginal de X depende del valor de X: B_1 + 2 B_2 X_i
	- El signo de B_2 hace que el efecto sea creciente (siempre a mas años mayor salario) o decreciente (en un momento ya no importa estudiar)
