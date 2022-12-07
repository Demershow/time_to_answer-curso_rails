require 'net/http'

class Cep 
  attr_reader :logradouro, :bairro, :localidade, :uf

  def initialize(cep)
    cep_encontrado = encontrar(cep)
    preencher_dados(cep_encontrado)
  end

private

  def preencher_dados(cep_encontrado)
    @logradouro = cep_encontrado["logradouro"]
    @bairro = cep_encontrado["bairro"]
    @localidade = cep_encontrado["localidade"]
    @uf = cep_encontrado["uf"]
  end

  def encontrar(cep)
    ActiveSupport::JSON.decode(
      Net::HTTP.get(
        URI("https://viacep.com.br/ws/#{cep}/json/")
      )
    )
  end
end
