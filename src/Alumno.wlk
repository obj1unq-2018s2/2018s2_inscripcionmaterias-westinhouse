
class Alumno {
	
	var property carrerasEnCurso   = null  // Lista de Carrera
	var property materiasAprobadas = null  // Lista de Materia_Aprobada
	var property materiasEnCurso   = null  // Lista de Materia
	var property materiasEnLaQueFiguraInscripto = null // Lista de Materia
	var property creditosAcumulados = 0     // Es un número
	var property materiasEnListaDeEspera = null	 // Lista de Materia
	
	
	method materiaPerteneceACarreraEnCurso(materia){
	 	/*
	 	 * Devuelve un booleano indicando si la materia dada por parámetro
	 	 * pertenece a alguna de las carreras que esta cursando el alumno.
	 	 */
	 	 
	 	 return carrerasEnCurso.any{
	 	 		carrera => carrera.materias().contains(materia)
	 	 }
	 }
	
	method aproboLaMateria(materia){
		/*
		 * Devuelve un booleano indicando si la materia pasada por parámetro
		 * pertenece a alguna de las materias que el alumno aprobó.
		 */
		 
		 return materiasAprobadas.any{
		 		materiaAprobada => materiaAprobada.nombreMateria() == materia
		 }
	}
	
	
	method estaInscriptoEnLaMateria(materia){
		/*
		 * Retorna un booleano indicando si el alumno está inscripto en 
		 * la materia indicada por el parámetro.
		 */
		 
		 return materiasEnLaQueFiguraInscripto.contains(materia)
	}
	
	method aproboLasMateriasCorrelativas(materia){
		/*
	 	 * Devuelve un booleano indicando si el alumno cuenta con todas 
	 	 * las materias correlativas aprobadas de una materia dada.
	 	 */
	 	 
	 	 return materia.materiasCorrelativas().all{
	 	 		materiaCorrelativa => self.aproboLaMateria(materiaCorrelativa)
	 	 }	
	}
	
	method aproboLasMateriasDeTalAnio(anio, carrera){
		/*
		 * Retorna un booleano que indica si el alumno aprobo todas las
		 * materias correspondientes al anio de la carrera específicados
		 * por parámetro.
		 */
		 
		 carrera.materiasPorAnio(anio).all{
			    materia => self.aproboLaMateria(materia)
			    }
	}
	
	method tieneLosCreditosNecesarios(materia){
		/*
		 * Devuelve True si el alumno posee créditos en cantidad mayor o igual
		 * a los créditos necesarios que solicita la materia para poder cursarla.
	 	 */
		 return creditosAcumulados >= materia.creditosNecesarios()	
	}
	
	
	//PUNTO 1	
	
	method puedeCursarMateria(materia, carrera){
		/* 
		 * Devuelve un booleano indicando si el estudiante
		 * cumple con los todos los requisitos necesarios para cursar una materia.
		*/
		return self.materiaPerteneceACarreraEnCurso(materia) &&
			   !self.aproboLaMateria(materia)&&
			   !self.estaInscriptoEnLaMateria(materia) &&
			   materia.cumpleConlosRequisitosParaCursar(self, carrera)
		
	}
	
	
	//PUNTO 2
	
	method aprobo(materia, notaMateria){
		/* Devuelve una nueva Materia_Aprobada a partir de la materia y nota 
		 * específicados por parámetros.
		 */
		 
		return new Materia_Aprobada( nombreMateria = materia, nota = notaMateria)
	}
	
	method registrarAprobacion(materia, notaMateria){
		/*
		 * Agrega a la lista de materias aprobadas por el alumno una nueva 
		 * materia_Aprobada cuya materia y nota estarán definidas 
		 * por los parámetros provistos. Si el alumno ya contaba con una nota
		 * de aprobación de dicha materia, no hace nada.
		 */
		 
		 
		 if(!self.aproboLaMateria(materia)){
		 materiasAprobadas.add(self.aprobo(materia, notaMateria))
		 } 
	}
	
	
	//PUNTO 3
	
	method inscribirseA(materia, carrera, criterio){
		/*
		 * Inscribe al alumno en una materia según el criterio de inscripcion 
		 * que maneje la materia. Esto tendrá los siguientes efectos:
		 * (Si la materia tiene cupo disponible):
		 * Agrega la materia a la lista de materias en las que el alumno figura inscripto.
		 * Agrega al estudiante a la lista de estudiantes inscriptos de la materia
		 * Incrementa el cupo de la materia en una unidad.
		 * Si la materia tiene el cupo lleno, el alumno pasa a estar en el ultimo lugar 
		 * de la lista de espera.
		 */
		 
		 if(materia.tieneCupoDisponible() && self.puedeCursarMateria(materia, carrera)){
		 	materia.inscribirSegunCriterio(self, criterio)
		 	materiasEnLaQueFiguraInscripto.add(materia)	 	
		 }
		 else{
		 	materia.agregarAListaDeEspera(self)
		 	materiasEnListaDeEspera.add(materia)
		 }
		
	}
	
	
	// PUNTO 4
	
	method darseDeBaja(materia){
		/*
		 * El alumno deja de cursar una materia. En consecuencia, dicha materia
		 * se removera de la lista en las que el alumno figura inscripto y
		 * de las que está cursando. 
		 * En lo concerniente a la materia, ésta borra de sus registros al alumno.
		 */
		
		materiasEnLaQueFiguraInscripto.remove(materia)
		materiasEnCurso.remove(materia)
		materia.darDeBaja(self)
	}
	
	
	// PUNTO 6
	
	method materiasDisponiblesParaCursar(carrera){
		
		if(carrerasEnCurso.contains(carrera)){
			return carrera.materias().filter{
				   materia => self.puedeCursarMateria(materia, carrera)
			}
		}
		else{	
			//Devolvería el siguiente mensaje de error:
			
			return "El alumno no está cursando esta carrera!"
		}
	}
	
	// PUNTO 8
	
	method promedio(){
		return materiasAprobadas.sum{ materia => materia.nota()} / materiasAprobadas.size()
	}
	
	
}