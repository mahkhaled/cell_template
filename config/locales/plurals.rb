{  :ar => { :i18n => { :plural => { :keys => [:one, :other], :rule => lambda { |n| (n == 1 || (11..99).include?(n%100)) ? :one : :other } } } }
}

 
