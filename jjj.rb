require "json"
require "selenium-webdriver"
require "rspec"
include RSpec::Expectations

describe "Test1" do

  before(:each) do
    @driver = Selenium::WebDriver.for :firefox
    @base_url = "https://staging.docdigitales.com/"
    @accept_next_alert = true
    @driver.manage.timeouts.implicit_wait = 30
    @verification_errors = []
  end

  after(:each) do
    @driver.quit
    @verification_errors.should == []
  end

  it "test_1" do
    @driver.get(@base_url + "/account/login")
    @driver.find_element(:id, "login").clear
    @driver.find_element(:id, "login").send_keys "ga.armol@outlook.com"
    @driver.find_element(:id, "btn-entrar-login").click
    !60.times{ break if (@driver.find_element(:id, "submenu_btn_precios").text == "Precios y Paquetes" rescue false); sleep 1 }
    !60.times{ break if (@driver.find_element(:id, "menu_btn_clientes").text == "Clientes" rescue false); sleep 1 }
    @driver.find_element(:id, "submenu_btn_precios").click
    @driver.find_element(:id, "menu_btn_clientes").click
    @driver.find_element(:id, "submenu_btn_staff_clientes").click
    @driver.find_element(:id, "submenu_btn_importar_clientes").click
    @driver.find_element(:id, "menu_btn_facturacion").click
    @driver.find_element(:id, "submenu_btn_facturas_recibidas").click
    @driver.find_element(:id, "submenu_btn_facturas_recurrentes").click
    @driver.find_element(:id, "submenu_btn_recepciones_pagos").click
    @driver.find_element(:id, "submenu_btn_importar_facturas").click
    @driver.find_element(:id, "submenu_btn_productos_admin").click
    @driver.find_element(:id, "menu_btn_cotizacion").click
    @driver.find_element(:id, "submenu_btn_productos_admin").click
    @driver.find_element(:id, "menu_btn_nomina").click
    !60.times{ break if (@driver.find_element(:id, "submenu_btn_staff_index").text == "Staff" rescue false); sleep 1 }
    @driver.find_element(:id, "submenu_btn_staff_index").click
    @driver.find_element(:id, "menu_btn_gastos").click
    @driver.find_element(:id, "submenu_btn_categorias").click
    @driver.find_element(:id, "menu_btn_reportes").click
    @driver.find_element(:id, "submenu_btn_graficas").click
    @driver.find_element(:id, "menu_btn_configuracion").click
    !60.times{ break if (@driver.find_element(:link, "Bancos").text == "Bancos" rescue false); sleep 1 }
    @driver.find_element(:link, "Bancos").click
    @driver.find_element(:link, "Impuestos").click
    @driver.find_element(:link, "Logo").click
    @driver.find_element(:link, "Factura").click
    @driver.find_element(:link, "Usuarios").click
    @driver.find_element(:link, "Certificados").click
    @driver.find_element(:link, "Correo").click
    @driver.find_element(:link, "Preferencias").click
    @driver.find_element(:id, "menu_btn_clientes").click
    @driver.find_element(:xpath, "//img[@alt='Nuevocliente boton']").click
    @driver.find_element(:id, "cliente_nombre").clear
    @driver.find_element(:id, "cliente_nombre").send_keys "Raul Reyes Montes"
    @driver.find_element(:id, "cliente_rfc").clear
    @driver.find_element(:id, "cliente_rfc").send_keys "Xexx010101000"
    Selenium::WebDriver::Support::Select.new(@driver.find_element(:id, "cliente_catalogo_uso_cfdi_id")).select_by(:text, "G01 - Adquisición de mercancias")
    @driver.find_element(:id, "cliente_calle").clear
    @driver.find_element(:id, "cliente_calle").send_keys "Santiago de Compostela"
    @driver.find_element(:id, "cliente_no_exterior").clear
    @driver.find_element(:id, "cliente_no_exterior").send_keys "289"
    @driver.find_element(:id, "cliente_no_interior").clear
    @driver.find_element(:id, "cliente_no_interior").send_keys "9"
    @driver.find_element(:id, "cliente_colonia").clear
    @driver.find_element(:id, "cliente_colonia").send_keys "Villas Del Rey"
    @driver.find_element(:id, "cliente_municipio").clear
    @driver.find_element(:id, "cliente_municipio").send_keys "Mexicali"
    @driver.find_element(:id, "cliente_localidad").clear
    @driver.find_element(:id, "cliente_localidad").send_keys "Mexicali"
    @driver.find_element(:id, "cliente_estado").clear
    @driver.find_element(:id, "cliente_estado").send_keys "Baja California"
    @driver.find_element(:id, "cliente_pais").clear
    @driver.find_element(:id, "cliente_pais").send_keys "Mexico"
    @driver.find_element(:id, "cliente_codigo_postal").clear
    @driver.find_element(:id, "cliente_codigo_postal").send_keys "21353"
    @driver.find_element(:id, "btn-guardar-cliente").click
    !60.times{ break if (@driver.find_element(:id, "div_msg_error").text == "El cliente se agregó con éxito" rescue false); sleep 1 }
    (@driver.find_element(:id, "div_msg_error").text).should == "El cliente se agregó con éxito"
    @driver.find_element(:link, "Salir").click
  end





  def verify(&blk)
    yield
  rescue ExpectationNotMetError => ex
    @verification_errors << ex
  end


end
