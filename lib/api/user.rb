
class User
  attr_reader :id, :first_name, :last_name, :email, :role

  def initialize(data)
    @id = data["id"]
    @first_name = data["first_name"]
    @last_name = data["last_name"]
    @email = data["email"]
    @role  = data["role"]
  end

  def attrs
    {
      id: id,
      first_name: first_name,
      last_name: last_name,
      email: email,
      role: role
    }
  end

  private

  attr_reader :data
end
