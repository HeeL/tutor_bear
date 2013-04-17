class Search

  attr_reader :who

  PER_PAGE = 25

  def initialize(options, current_user)
    @options = options
    @current_user = current_user
    find_users
  end

  def get_count
    @users.count
  end

  def get_result
    @users.offset(@options[:offset]).limit(PER_PAGE)
  end

  private

  def find_users
    add_who_condition
    add_price_condition
    exclude_current_user
    add_lang_condition
  end

  def add_who_condition
    if @options[:who] == 'learner'
      @who = :learner
      @users = User.where(learn: true).joins(:learner)
    else
      @who = :teacher
      @users = User.where(teach: true).joins(:teacher)
    end
  end

  def add_price_condition
    if @options[:price].present?
      no_price_cond = @options[:no_price_set] ? 'OR min_price + max_price = 0' : 'AND min_price + max_price > 0'
      @users = @users.where("min_price <= ? #{no_price_cond}", @options[:price].to_i)
    elsif !@options[:no_price_set]
      @users = @users.where("min_price + max_price > 0")
    end
  end

  def exclude_current_user
    @users = @users.where('users.id != ?', @current_user.id) if @current_user
  end

  def add_lang_condition
    if @options[:langs].present?
      langs = Language.with_translations.where('language_translations.name' => @options[:langs].split(',')).map(&:id)
      @users = @users.where("#{@who}s.id IN (
        SELECT #{@who}_id
        FROM languages_#{@who}s ll
        WHERE #{@who}s.id = ll.#{@who}_id
        AND language_id IN (?))", langs)
    end
  end


end