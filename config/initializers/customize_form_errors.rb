ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
  %(<div class="has-error">
    #{html_tag}
    <p class="help-block">#{instance.error_message.collect { |e| e.capitalize }.to_sentence}</p>
    </div>).html_safe
end
