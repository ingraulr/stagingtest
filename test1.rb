require "json"
require "selenium-webdriver"
gem "test-unit"
require "test/unit"

class Test1 < Test::Unit::TestCase

  def setup
    @driver = Selenium::WebDriver.for :chrome
    @base_url = "https://staging.docdigitales.com/"
    @accept_next_alert = true
    @driver.manage.timeouts.implicit_wait = 30
    @verification_errors = []
    @driver.manage().window().maximize();
  end

  def teardown
    @driver.quit
    assert_equal [], @verification_errors
  end

  def test_1
    @driver.get(@base_url + "/account/login")
    @driver.find_element(:id, "login").clear
    @driver.find_element(:id, "login").send_keys "ga.armol@outlook.com"
    @driver.find_element(:id, "password").send_keys "rau246rey"
    @driver.find_element(:id, "btn-entrar-login").click
    assert !60.times{ break if (@driver.find_element(:id, "submenu_btn_precios").text == "Precios y Paquetes" rescue false); sleep 1 }
    @driver.find_element(:id, "submenu_btn_precios").click
    assert !360.times{ break if (@driver.find_element(:id, "menu_btn_clientes").text == "Clientes" rescue false); sleep 1 }
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
    assert !60.times{ break if (@driver.find_element(:id, "submenu_btn_staff_index").text == "Staff" rescue false); sleep 1 }
    @driver.find_element(:id, "submenu_btn_staff_index").click
    @driver.find_element(:id, "menu_btn_gastos").click
    @driver.find_element(:id, "submenu_btn_categorias").click
    @driver.find_element(:id, "menu_btn_reportes").click
    @driver.find_element(:id, "submenu_btn_graficas").click
    @driver.find_element(:id, "menu_btn_configuracion").click
    assert !60.times{ break if (@driver.find_element(:link, "Bancos").text == "Bancos" rescue false); sleep 1 }
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
    @driver.find_element(:id, "cliente_codigo_postal").send_keys(Keys.ArroDown);
    @driver.find_element(:id, "btn-guardar-cliente").click
    assert !60.times{ break if (@driver.find_element(:id, "div_msg_error").text == "El cliente se agregó con éxito" rescue false); sleep 1 }
    assert_equal "El cliente se agregó con éxito", @driver.find_element(:id, "div_msg_error").text
    @driver.find_element(:link, "Salir").click
  end


  def element_present?(how, what)
    @driver.find_element(how, what)
    true
  rescue Selenium::WebDriver::Error::NoSuchElementError
    false
  end

  def alert_present?()
    @driver.switch_to.alert
    true
  rescue Selenium::WebDriver::Error::NoAlertPresentError
    false
  end

  def verify(&blk)
    yield
  rescue Test::Unit::AssertionFailedError => ex
    @verification_errors << ex
  end

  def close_alert_and_get_its_text(how, what)
    alert = @driver.switch_to().alert()
    alert_text = alert.text
    if (@accept_next_alert) then
      alert.accept()
    else
      alert.dismiss()
    end
    alert_text
  ensure
    @accept_next_alert = true
  end
end
