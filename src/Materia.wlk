
class Materia {
		
	var property creditosQueOtorga = 0
	//Se setea un número que indica los creditos obtenidos al aprobar la materia.
	
	var property anio = 0
	// Se setea un número indicando el año de la carrera al que la materia pertenece.
	
	var property carreraALaQuePertenece = null 
	// Se setea la carrera a la que pertenece esta materia.
	
	//Atributos pertinentes al punto 3
	
	var property cupo = 0
	// Es un número que indica la cantidad de estudiantes que el curso admite.
	
	var property alumnosEnEspera = null 
	// Lista de Alumno que están en lista de espera para anotarse.
	
	var property alumnosInscriptos = null 
	//Conjunto de Alumno inscriptos en la materia. 
	//La cantidad de elementos de este conjunto debe ser igual o menor al cupo.
	
	
	
	
	method cumpleConLosRequisitosParaCursar(alumno, carrera){
		//Retorna siempre TRUE debido a que la clase Materia no tiene requisitos para cursar.	
		return true
	}
	
	//Métodos requeridos para el punto 3
	
	method tieneCupoDisponible(){
		// Indica mediante un booleano si hay cupo disponible en la materia.
		
		return alumnosInscriptos.size() < cupo
	}
	
	method inscribirAlumno(alumno){
		// Agrega al conjunto de alumnos inscriptos el alumno dado.
		
		alumnosInscriptos.add(alumno)
		cupo += 1
	}
	
	method agregarAListaDeEspera(alumno){
		// Agrega a la lista de alumnos en espera al alumno dado.
		
		alumnosEnEspera.add(alumno)
	}
	
	// Métodos requeridos para el punto 4
	
	method darDeBajaA(alumno){
		/*
		 * Remueve a alumno de la lista de alumnos inscriptos. Además, agrega
		 * a esta lista al primer alumno en la lista de espera.
		 */
		 
		 alumnosInscriptos.remove(alumno)
		 alumnosInscriptos.add(alumnosEnEspera.first())
		 alumnosEnEspera.remove(alumnosEnEspera.first())
	}
	
	// Métodos requeridos para el punto 8
	
	method inscribirSegunCriterio(criterio){
		/*
		 * Inscribe de la lista de alumnos en espera al alumno 
		 * seleccionado según el criterio especificado.
		 */
		 
		 criterio.inscribirAlumno(self)
	}
		
}

class Materia_ConCorrelativas inherits Materia {
	
	var property materiasCorrelativas = null 	
	// Lista de Materias
	
	
	override method cumpleConLosRequisitosParaCursar(alumno, carrera){
		/*
		 * Devuelve un booleano indicando si el alumno cumple con 
		 * las materias correlativas necesarias
		 */
		return alumno.aproboLasMateriasCorrelativas(self)
	}
}

class Materia_ConCreditos inherits Materia {
	
	var property creditosNecesarios = 0 
	// Se setea un número cuando se instancia esta clase.
	
	
	override method cumpleConLosRequisitosParaCursar(alumno, carrera){
		/*
		 * Devuelve un booleano indicando si el alumno tiene los créditos
		 * necesarios para cursar la materia.
		 */
		return alumno.tieneLosCreditosNecesarios(self)
	}
}


class Materia_Avanzada inherits Materia {
	
	override method cumpleConLosRequisitosParaCursar(alumno, carrera){
		/*
		 * Retorna True si el alumno aprobo todas las materias de determinado 
		 * año que sean requisitos para cursar la materia.
		 */
		return alumno.aproboLasMateriasDeTalAnio(anio - 1, carrera)
	}
}






