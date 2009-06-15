  require 'xmlcodec'

  class Root < XMLCodec::XMLElement
    elname 'Lug - Tucumán'
    xmlsubel :firstelement
  end

  class FirstElement < XMLCodec::XMLElement
    elname 'firstelement'
    xmlsubel_mult :secondelement
  end

  class SecondElement < XMLCodec::XMLElement
    elname 'secondelement'
    elwithvalue
    xmlattr :firstattr
  end


#http://xmlcodec.rubyforge.org/
