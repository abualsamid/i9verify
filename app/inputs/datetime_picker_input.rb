# app/inputs/date_picker_input.rb

class DatetimePickerInput < SimpleForm::Inputs::StringInput 
  def input                    
    value = object.send(attribute_name) if object.respond_to? attribute_name
    input_html_options[:value] ||= I18n.localize(value) if value.present?
    input_html_classes << "datetimepicker"

    super # leave StringInput do the real rendering
  end
end
