extends Control

func add_marker( type, id, pos ): # type can be unit, object or building
	$viewport_container/viewport.add_marker( type, id, pos )
