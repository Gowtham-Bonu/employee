class EmployeesController < ApplicationController
  def new
    @employee = Employee.new
  end

  def create
    @employee = Employee.find_or_create_by(employee_params)
    if @employee
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def index
    if params[:email_entered] and params[:commit] == "Search"
      @employee = Employee.find_by(email: params[:email_entered].strip)
    else
      @employees = Employee.all
    end
  end

  def edit
    @employee = Employee.find_or_initialize_by(id: params[:id])
  end

  def update
    @employee = Employee.find_or_initialize_by(id: params[:id])

    if @employee.update(employee_params)
      redirect_to root_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def increment
    Employee.limit(10).find_in_batches(batch_size: 10).each do |batch|
      batch.each do |employee|
        employee.no_of_order += 1
        employee.save
      end
    end
    redirect_to employees_path
  end

  def decrement
    Employee.limit(10).find_in_batches(batch_size: 10).each do |batch|
      batch.each do |employee|
        employee.no_of_order -= 1
        employee.save
      end
    end
    redirect_to employees_path
  end

  def destroy
    @employee = Employee.find_or_initialize_by(id: params[:id])
    @employee.destroy

    redirect_to root_path, status: :see_other
  end

  def results
    @employees_age = Employee.where(age: 20..40)
    @employees_true = Employee.where(full_time_available: true)
    @employees_orders = Employee.where("age > ? AND no_of_order = ?", 25, 5)
    @employees_past = Employee.where(created_at: ..Time.now.midnight-1)
    @employees_less_orders = Employee.where(" age < 25 OR no_of_order = 5 ")
    @employees_desc = Employee.order(age: :desc)
    @employees_asc = Employee.order(:no_of_order)
    @employees_high = Employee.where(salary: 45001..)
    @employees_group = Employee.where(no_of_order: 6..)
    @employees_unscope_false = Employee.where(age: 50..)
    @employees_unscope_true = Employee.where(age: 50..).unscope(where: :age)
    @employees_only_false = Employee.order(id: :desc).limit(2)
    @employees_only_true = Employee.order(id: :desc).limit(2).only(:order)
    @employees_reselect_false = Employee.select(:first_name, :age, :salary)
    @employees_reselect_true = Employee.select(:first_name, :age, :salary).reselect(:first_name, :created_at)
    @employees_reorder_false = Employee.order(:id)
    @employees_reorder_true = Employee.order(:id).reorder(id: :desc)
    @employees_reverse_order_false = Employee.order(:id)
    @employees_reverse_order_true = Employee.order(:id).reverse_order
  end

  private

  def employee_params
    params.require(:employee).permit(:first_name, :last_name, :email, :age, :no_of_order, :full_time_available, :salary)
  end
end
