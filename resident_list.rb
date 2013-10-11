module ResidentList
  # eval ( "#{} = Resident.first(:lastname => '#{obj_name}')" )
  Resident.all do |r|
    eval ( "#{r.fullname_joined} = 
              Resident.first( 
                  :lastname => '#{r.lastname}', 
                  :firstname => '#{r.firstname}' 
              )"
          )
  end
end
