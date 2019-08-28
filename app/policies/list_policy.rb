class ListPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all.sort_by{ |l| l.title  }
    end
  end

  def create?
    true
  end

  def show?
    true
  end

  def update?
    record.user == user
  end

  def destroy?
    update?
  end
end
