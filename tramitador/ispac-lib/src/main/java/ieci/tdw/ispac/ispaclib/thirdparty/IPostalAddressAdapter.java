package ieci.tdw.ispac.ispaclib.thirdparty;

/**
 * Interfaz del adaptador para contener la informaci�n de la direcci�n postal
 * de un tercero.
 *
 */
public interface IPostalAddressAdapter {

	public String getId();
	
	public String getDireccionPostal();

	public String getTipoVia();
	
	public String getVia();
	
    public String getBloque();

    public String getPiso();
    
    public String getPuerta();

    public String getCodigoPostal();

    public String getPoblacion();

    public String getMunicipio();
    
    public String getProvincia();

    public String getComunidadAutonoma();

    public String getPais();
    
    public String getTelefono();
    
}