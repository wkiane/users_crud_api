class UserPolicy < ApplicationPolicy	
  def index?
    user.role == 'admin'
  end

  def show?
    user.role == 'admin' || user == record
  end

  def update?
    user.role == 'admin' || user == record
  end

  def destroy?
    user.role == 'admin' || user == record
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
