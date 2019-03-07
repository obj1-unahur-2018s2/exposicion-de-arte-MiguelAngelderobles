object rojo { method vistasPorDia() = 2500 }
object azul { method vistasPorDia() = 120 }
object verde { method vistasPorDia() = 1400 }
object violeta { method vistasPorDia() = 380 }
object fucsia { method vistasPorDia() = 1800 }
object amarillo { method vistasPorDia() = 1000 }
object marron { method vistasPorDia() = 90 }
object naranja { method vistasPorDia() = 200 }

object exposicion{
	var cantPersonasDeIngreso
	var obras=[]
	var jurado=[]
	var muestras=[]
	method setMuestras(_muestras){
		muestras.add(_muestras)
	}
	method regisObras(){
		return muestras.all{
			p=>p.obras()==obras
		}
	}
	method obrasDiasTotal(){
		return muestras.sum{
			p=>p.dias()
		}
	}
	method setJurado(_artistas){
		jurado.add(_artistas)
	}
	method artistaInfluyente(artista){
		return jurado.any({p=>p.maestro()==artista})
	}
	method setObras(_obras){
		obras.add(_obras)
	}
	method debenSerRestauradas(){
		return obras.filter({
			p=>p.debeRepararse()})
	}
	method esBrillante(){
		return obras.all({
			p=>p.esRelevante()
		})
	}
	method conjuntoAutoresObrasFormanParte(){
		return obras.map({
			p=>p.artista()
		}).asSet()
		
	} 
	method cantObrasXArtista(_artistas){
		return obras.filter({
			p=>p.artista()==_artistas
		}).size()
	}
	method conjDeObrasEsInfluyente(){
		return obras.filter({
			p=>self.artistaInfluyente(p.artista())
			})}
	
	method artistaConMasObras(){
		return obras.max({
			p=>self.cantObrasXArtista(p.artista())})
}
	method setCantPersonasDeIngreso(_cantPersonasDeIngreso){
		cantPersonasDeIngreso=_cantPersonasDeIngreso
	}
	method cantPersonasDeIngreso(){
		return cantPersonasDeIngreso
	}
	method estaInhabilitada(_obra){
		return jurado.contains(_obra.artista())
	}
	method puedeFormarParte(_obra){
		return !self.estaInhabilitada(_obra)
		and _obra.requisitosDeIngreso(self)
	}
	method incorpore(_obra){
		return if (!self.puedeFormarParte(_obra)){
			self.error("no nai ")
		}else{
			obras.add(_obra)
		}
	}
	method estaBienArmada(_obra){
		return obras.all({p=>self.puedeFormarParte(_obra)})
	}
	method activarMuestra(muestra){
		return muestra.activate()
	}
}
class Artista{
	var maestro
	method setMaestro(_maestro){
		maestro=_maestro
	}
	method maestro(){
		return maestro
	}
	
}
class Obra{
	var artista
	var color=[]
	var personasEstimadas
	method setArtista(_artista){artista=_artista}
	method artista(){
		return artista
	}
	method setColor(_color){color.add(_color)}
	method color(){
		return color
	}
	method setPersonasEstimadas(_personasEstimadas){
		personasEstimadas=_personasEstimadas
	}
	method personasEstimadas(){
		return personasEstimadas
	}
	method esRelevante(){return 0}
	method nivelDeDesgaste(){
		return 0
	}
	method requisitosDeIngreso(expo){
		return (color.contains(rojo) 
		or color.contains(amarillo) 
		or color.contains(naranja))
	}
	
}
class Pintura inherits Obra{
	var nivelDeDesgaste
	override method esRelevante(){
		return personasEstimadas>10000
	}
	method setNivelDeDesgaste(_nivelDeDesgaste){
		nivelDeDesgaste=_nivelDeDesgaste
	}
	method debeRepararse(){
		return nivelDeDesgaste>=200
	}
	override method nivelDeDesgaste(){
		return nivelDeDesgaste
	}
	override method requisitosDeIngreso(expo){
		return super(expo) 
		and personasEstimadas>=expo.cantPersonasDeIngreso()
	}
	
}
class Fotografia inherits Obra{
	override method esRelevante(){
		return color.size()>3
	}
	 method debeRepararse(){
		return false
	}
	override method requisitosDeIngreso(expo){
		return super(expo) 
		and personasEstimadas>=expo.cantPersonasDeIngreso()+1000 
		and (color.contains(verde)
		or color.contains(marron))
	}

}

class MuestrasCromaticas{
	
	var color
	
	var dias
	
	var obras=[]
	method obras(){
		return obras
	}
	method setObras(_obras){
		obras.add(_obras)
	}
	method setColor(_color){
		color=_color
	}
	
	method color(){
		return color
	}
	
	method setDias(_dias){
		dias=_dias
	}
	
	method dias(){
		return dias
	}
	method activate(){
		return if(obras.contains({p=>p.color()==color})){
			obras.setNivelDeDesgaste(dias)
			obras.setPersonasEstimadas(color.vistasPorDia()*dias +obras.personasEstimadas())+obras.nivelDeDesgaste()
		}else{
			obras.setNivelDeDesgaste(dias)
			obras.setPersonasEstimadas((color.vistasPorDia()*dias +obras.personasEstimadas())/2)+obras.nivelDeDesgaste()
		} 
	}
}

class Escultura inherits Obra{
	var peso 
	const colaboradores=[]
	method pesoXKg(){
		return peso
	}
	method 	setPesoXKg(_peso){
		peso=_peso
	}
	method colaboradores(artistas){
		colaboradores.add(artistas)
	}
	override method esRelevante(){
		return peso>200 or colaboradores.contains({p=>artista.maestro()})
	}	
 	override method requisitosDeIngreso(expo){
 		return super(expo)
 		and personasEstimadas>=expo.cantPersonasDeIngreso()+1000 
		and (color.contains(verde)
		or color.contains(marron))
		and peso<500
 	}
}


//class MuestrasCromaticas{
	

