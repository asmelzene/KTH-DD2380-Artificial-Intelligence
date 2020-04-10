;; Domain definition
(define (domain assembling-domain)

  ;; Predicates: Properties of objects that we are interested in (boolean)
  (:predicates
    (PERSON ?x) ; True if x is a person
    (WOOD ?x) ; True if x is a wood
    (TOOL ?x) ; True if x is a tool
    (CAN-PAINT ?x) ; True if x is a tool that can be used for painting
    (CAN-HIT ?x) ; True if x is a tool that can be used for hitting
    (free-tool ?x) ; True if tool x is free for grabs
    (free-wood ?x) ; True if wood x is free for grabs
    (person-holds-something ?x) ; True if person x holds something
    (person-holds-tool ?x ?y) ; True if person x holds tool y
    (person-holds-wood ?x ?y) ; True if person x holds wood y
    (wood-painted ?x) ; True if x is a wood and it is painted
    (wood-nailed ?x) ; True if x is a wood and it contains a nail
    (approved ?x) ; True if x is correctly assembled
  )

  ;; Actions: Ways of changing the state of the world

  ; Person x can grab a tool y if they do not hold anything yet and if the tool is free
  ; As a result they hold the tool, and the tool is not free any more 
  ; Parameters:
  ; - x: the person  
  ; - y: the tool  
  (:action grab-tool
    ; WRITE HERE THE CODE FOR THIS ACTION
    :parameters (?x ?y)
    :precondition 
	(and 
		(PERSON ?x) 
		(TOOL ?y) 
		(not (person-holds-something ?x)) 
		(free-tool ?y))
    :effect 
	(and 
		(person-holds-tool ?x ?y) 
		(person-holds-something ?x)
		(not (free-tool ?y))
	)
  )

  ; Person x can drop a tool y if they hold the tool   
  ; As a result the person stops holding the tool, and the tool becomes free
  ; Parameters:
  ; - x: the person  
  ; - y: the tool 
  (:action drop-tool
    ; WRITE HERE THE CODE FOR THIS ACTION
    :parameters (?x ?y)
    :precondition 
	(and 
	    (PERSON ?x) 
		(TOOL ?y) 
		(person-holds-tool ?x ?y)
		(person-holds-something ?x)
		(not (free-tool ?y))
	)
    :effect 
	(and 
	 	(not (person-holds-tool ?x ?y)) 
		(not (person-holds-something ?x)) 
		(free-tool ?y))
  )
  
  (:action drop-wood
    ; WRITE HERE THE CODE FOR THIS ACTION
    :parameters (?x ?y)
    :precondition 
	(and 
	    (PERSON ?x) 
		(WOOD ?y) 
		(person-holds-wood ?x ?y)
		(person-holds-something ?x)
		(not (free-wood ?y))
	)
    :effect 
	(and 
	 	(not (person-holds-wood ?x ?y)) 
		(not (person-holds-something ?x)) 
		(free-wood ?y))
  )
  
  ; Person x can grab a wood y if they do not hold anything yet and if the wood is free
  ; As a result they hold the wood, and the wood is not free any more 
  ; Parameters:
  ; - x: the person  
  ; - y: the wood  
  (:action grab-wood
    :parameters (?x ?y)
    :precondition 
	(and 
		(PERSON ?x) 
		(WOOD ?y) 
		(not (person-holds-something ?x)) 
		(free-wood ?y))
    :effect 
	(and 
		(person-holds-wood ?x ?y) 
		(person-holds-something ?x)
		(not (free-wood ?y)))
  )

  ; Person x1 can paint wood y with a tool z if person x1 is holding z, if z can be used for painting and if person x2 is holding wood y
  ; As a result the wood y becomes painted
  ; Parameters:
  ; - x1, x2: the people 
  ; - y: the wood
  ; - z: the tool 
  (:action paint
    :parameters (?x1 ?x2 ?y ?z)
    :precondition 
	(and 
		(PERSON ?x1) 
		(PERSON ?x2) 
		(WOOD ?y) 
		(TOOL ?z) 
		(person-holds-tool ?x1 ?z) 
		(CAN-PAINT ?z) 
		(person-holds-wood ?x2 ?y))
    :effect 
		(wood-painted ?y) ; and removed
  )
  
  ; Person x1 can nail wood y with a tool z if x1 is holdind z, if z can be used for hitting, 
  ; if wood y is painted and if person x2 is holding wood y
  ; As a result the wood y has a nail but is still not approved
  ; Parameters:
  ; - x1, x2: the people  
  ; - y: the wood
  ; - z: the tool
  (:action nail
    :parameters (?x1 ?x2 ?y ?z)
    :precondition 
	(and 
	(PERSON ?x1) 
	(PERSON ?x2) 
	(WOOD ?y) 
	(TOOL ?z) 
	(person-holds-tool ?x1 ?z) 
	(CAN-HIT ?z) 
	(wood-painted ?y) 
	(person-holds-wood ?x2 ?y))
    :effect 
	(and 
		(wood-nailed ?y) 
		(not (approved ?y))
	)
  )
   
  ; Person x can inspect wood y if y has been nailed and if person x is holding the wood y
  ; As a result wood y becomes approved
  ; Parameters:
  ; - x: the person  
  ; - y: the wood 
  (:action approve
    :parameters (?x ?y)
    :precondition 
	(and 
		(PERSON ?x) 
		(WOOD ?y) 
		(wood-nailed ?y) 
		(person-holds-wood ?x ?y))
    :effect 
		(approved ?y) ; and removed
  )
)