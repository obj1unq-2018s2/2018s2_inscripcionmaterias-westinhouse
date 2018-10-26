class Criterio{
	
	method inscribirAlumno(materia, alumno) {}
}


class OrdenDeLlegada inherits Criterio {
	
	override method inscribirAlumno(materia, alumno){
 		/*
	 	 * Inscribe a un alumno a la materia. Si no hay cupo,
		 * agrega al alumno a la lista de espera de la materia
		 * según el orden llegada (Es decir, lo agrega al final).
		 */
		 
	 	 if(materia.hayCupoDisponible()){
			materia.inscribirAlumno()
		 }
		 else{
		 	 materia.alumnosInscriptos().add(self.primeroDeLaLista(materia))
	}
}	
	method primeroDeLaLista(materia){
		// Devuelve al primer alumno de la lista de espera de la materia.
		return materia.alumnosEnEspera().first()
	}
}

class MejorPromedio inherits Criterio {
	
	override method inscribirAlumno(materia, alumno){
	 	/*
	 	 * Inscribe a un alumno de la lista de espera de la materia dada
		 * según el promedio
		 */
		 
		 materia.alumnosInscriptos().add(self.mejorPromedio(materia))
	}
	
	method mejorPromedio(materia){
		
		return materia.alumnosEnEspera().max{ alumno => alumno.promedio()}
	}
	
}

class GradoDeAvance inherits Criterio {
	
	override method inscribirAlumno(materia, alumno){
		/*
	 	 * Inscribe a un alumno de la lista de espera de la materia dada
		 * según el grado de avance en la carrera.
		 */
		 
		 materia.alumnosInscriptos().add(self.mayorAvanceEnLaCarrera(materia))
	}
	
	method mayorAvanceEnLaCarrera(materia){
		// Devuelve el alumno con mayor cantidad de materias aprobadas.
			
		return materia.alumnosEnEspera().max{ alumno => alumno.materiasAprobadas().size()}
	}
}

class Ninguno inherits Criterio {
	
	override method inscribirAlumno(materia, alumno){
	//Inscribe al alumno directamente.	
		materia.inscribirAlumno(alumno)
	}
}

