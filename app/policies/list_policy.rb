class ListPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all.sort_by(&:title)
    end
  end

  def index?
    true
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

  def flashcard?
    true
  end

  def good_answer?
    true
  end
end
