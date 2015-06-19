class SessionsController < Clearance::SessionsController

  def destroy
    sign_out
    redirect_to(url_after_destroy)
  end

private

  def url_after_destroy
    home_path
  end
end
