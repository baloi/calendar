module TherapistList
  #Adrian = Therapist.first(:firstname => "Adrian")
  #Estella = Therapist.first(:firstname => "Estella")
  #Jean = Therapist.first(:firstname => "Jean")
  #Florabel = Therapist.first(:firstname => "Florabel")
  #Eric = Therapist.first(:firstname => "Eric")
  #Peggy = Therapist.first(:firstname => "Peggy")
  #Kevin = Therapist.first(:firstname => "Kevin")

  Therapist.all do |r|
    eval ( "#{r.firstname} = 
              Therapist.first( 
                  :lastname => '#{r.lastname}', 
                  :firstname => '#{r.firstname}' 
              )"
          )
  end

end
