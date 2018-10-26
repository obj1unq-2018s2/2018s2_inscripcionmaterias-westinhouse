
class Carrera {
	
	var property materias = null
	//Lista de Materia
	
	var property alumnosInscriptos = null
	//Lista de Alumno anotados a la carrera.
	
	
	method agregarMateria(materia){
		materias.add(materia)
	}
	
	method agregarAlumno(alumno){
		alumnosInscriptos.add(alumno)
	}
	method materiasPorAnio(anio){
		/*
		 * Devuelve las materias de la carrera del anio de cursada 
		 * específicado. El resultado es un conjunto de Materia.
		 */
		 
		 return materias.filter{
		 		materia => materia.anio() == anio
		 }
	}
	
	

}

class Materia_Aprobada{
	
	var property nota = 4 // Es un número que representa la nota de aprobación.
	var property nombreMateria // Es una Materia.
}
}