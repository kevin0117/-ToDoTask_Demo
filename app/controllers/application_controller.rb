class ApplicationController < ActionController::Base
  before_action :set_locale

  around_action :switch_locale
 
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def switch_locale(&action)
    locale = params[:locale] || I18n.default_locale
    I18n.with_locale(locale, &action)
  end
  
  def default_url_options(options = {})
     { :locale => I18n.locale }.merge options
  end

  def extract_locale_from_tld
    parsed_locale = request.subdomains.first
    I18n.available_locales.map(&:to_s).include?(parsed_locale) ? parsed_locale : nil
  end

  helper_method :current_user, :logged_in?, :ransack_obj, :ransack_tasks

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def login_check
    if !logged_in?
      redirect_to root_path, notice: "請先登入"
    end
  end

  def same_user_check
    if !(current_user.id == @task.user_id)
      redirect_to users_path, notice: "你只能編輯或刪除自己的任務"
    end
  end

  def ransack_obj
    @q = Task.ransack(params[:q])
  end

  def ransack_tasks
    @q = Task.ransack(params[:q])
    @tasks = @q.result(distinct: true).page params[:page]
  end
  
end


