module ApplicationHelper
  def gravatar_url(user)
    gravatar_id = Digest::MD5::hexdigest(user.email).downcase
    url = "https://gravatar.com/avatar/#{gravatar_id}.png"
  end

  def custom_bootstrap_flash
    flash.each_with_object([]) do |(type, message), flash_messages|
    type = 'success' if type == 'notice'
    type = 'error' if type == 'alert'
    text = "<script>toastr.#{type}('#{message}', '', { closeButton: true, progressBar: true })</script>"
    flash_messages << text.html_safe if message
  end.join("\n").html_safe
  end

end
