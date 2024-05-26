require 'rails_helper'

RSpec.describe Product, type: :model do
  subject do
    described_class.new(id: 1,
                        nombre: 'algas',
                        tipo: 'Producto',
                        descripcion: 'Lorem ipsum',
                        precio: 30,
                        created_at: DateTime.now,
                        updated_at: DateTime.now + 1.week)
  end

  it 'Auction is valid with valid attributes' do
    expect(subject).to be_valid
  end
  it "Auction is valid with the 'tipo' Evento" do
    subject.tipo = 'Evento'
    expect(subject).to be_valid
  end
  it "Auction is not valid with the 'descripcion' nil" do
    subject.descripcion = nil
    expect(subject).not_to be_valid
  end
end
