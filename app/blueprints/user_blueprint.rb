# frozen_string_literal: true

class UserBlueprint < Blueprinter::Base
  identifier :id
  view :normal do
    fields :email
  end

  view :extended do
    include_view :normal
    fields :id, :created_at, :update_at
  end
end
