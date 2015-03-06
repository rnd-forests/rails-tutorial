jQuery ->

    # Make embedded videos responsive
    $('.article-wrapper').find('iframe').wrap("<div class='embed-responsive embed-responsive-16by9'></div>");

    # Article form
    picture = $('#article_picture')
    tags_select_box = $('#tags-list-selection')
    summernote = $('#summernote')

    picture.bind "change", ->
        size_in_megabytes = this.files[0].size / 1024 / 1024
        if size_in_megabytes > 5
            $('#picture-size-modal').modal("show")

    tags_select_box.select2({
        placeholder: 'choose tags for article',
        allowClear: true
    });

    summernote.summernote({
        focus: true,
        fontNames: [
            'Arial', 'Arial Black', 'Comic Sans MS', 'Source Sans Pro Regular',
            'Courier New', 'Helvetica Neue', 'Impact', 'Lucida Grande',
            'Tahoma', 'Times New Roman', 'Verdana', 'Futura-Medium'
        ],
        toolbar: [
            ['action', ['undo', 'redo']],
            ['fontsize', ['fontsize']],
            ['style', ['bold', 'italic', 'underline', 'strikethrough', 'clear']],
            ['fontname', ['fontname']],
            ['color', ['color']],
            ['layout', ['ul', 'ol']],
            ['para', ['paragraph']],
            ['height', ['height']],
            ['insert', ['picture', 'link', 'video', 'table', 'hr']],
            ['misc', ['fullscreen', 'codeview']]
        ]
    });