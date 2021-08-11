module ApplicationHelper
    # to make sure the pagy helpers in the views are available
    include Pagy::Frontend

    # to style the flash warnings w/ bootstrap

    def bootstrap_class_for(flash_type)
        case flash_type
        when "success"
            "alert-success"
        when "error"
            "alert-danger"
        when "alert"
            "alert-warning"
        when "notice"
            "alert-info"
        else
            flash_type.to_s
        end
    end
end
    