class CreateWkSalaryComponents < ActiveRecord::Migration
  def change
    create_table :wk_salary_components do |t|
      t.string :name
      t.string :frequency, :null => false, :limit => 3, :default => 'm'
      t.date :start_date
      t.string :type, :null => false, :limit => 3
	  t.references :dependent, :class => "WkSalaryComponents", :null => true
      t.string :pay_period, :null => false, :limit => 3, :default => 'm'
      t.float :factor
      t.string :salary_type, :null => false, :limit => 3, :default => 's'
	  t.timestamps null: false
    end
	
	create_table :wk_user_salary_components do |t|
      t.references :user, :null => false
	  t.references :salary_component, :class => "WkSalaryComponents", :null => false
	  t.references :dependent, :class => "WkSalaryComponents", :null => true
      t.float :factor
	  t.timestamps null: false
    end
	add_index  :wk_user_salary_components, :user_id
	add_index  :wk_user_salary_components, :salary_component_id
	
	create_table :wk_salary do |t|
      t.references :user, :null => false
	  t.references :salary_component, :class => "WkSalaryComponents", :null => false
      t.float :amount
      t.date :salary_date
	  t.timestamps null: false
    end
	add_index  :wk_salary, :user_id
	add_index  :wk_salary, :salary_component_id
	add_index  :wk_salary, :salary_date

  end
end
