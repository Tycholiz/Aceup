module ApplicationHelper
	def show_errors(object, field_name)
	  if object.errors.any?
	    if !object.errors.messages[field_name].blank?
	      object.errors.messages[field_name].join(", ")
	    end
	  end
	end 

	def bootstrap_class_for(flash_type)
	  case flash_type
	  when "success"
	    "alert-success"   # Green
	  when "error"
	    "alert-danger"    # Red
	  when "alert"
	    "alert-warning"   # Yellow
	  when "notice"
	    "alert-info"      # Blue
	  else
	    flash_type.to_s
	  end
	end



	
end
