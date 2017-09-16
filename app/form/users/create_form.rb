class Users::CreateForm
  include DryValidationForm

  Schema = Dry::Validation.Form do
    required(:name).filled(:str?)
    required(:email).filled(:str?)
    required(:password).filled(:str?)
    required(:password_confirmation).filled(:str?)
  end
end
