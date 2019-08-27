class WordPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    false
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
