jQuery ->

    # General notifications
    $('div.alert-success').delay(3000).slideUp();
    $('div.alert-info').delay(3000).slideUp();
    $('[data-toggle="tooltip"]').tooltip();

    # Search form
    search_form = $('#search-form')
    search_box = $('#keyword')

    search_box.on "input", ->
        input = $.trim($(this).val())
        if !input || input.length == 0
            $(this).popover('toggle')
        else
            $(this).popover('hide')

    search_form.on "submit", ->
        input = $.trim(search_box.val())
        if !input || input.length == 0
            $('#search-keyword-modal').modal("show")
            search_box.popover('hide')
            return false
