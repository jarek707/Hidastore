xml.instruct!
xml.fields do
  @fields.each do |field|
    xml.tag!('field', :id => field.id.to_s(), :type => 'integer') do
      xml.title field.label
      xml.dom field.dom
    end
  end
end
