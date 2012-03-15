xml.instruct!
xml.fields do
  @fields.each do |field|
    xml.id field.id
    xml.dom field.dom
  end
end
