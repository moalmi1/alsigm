package solicitudes.prestamos.forms;

import java.util.Date;

import solicitudes.forms.SolicitudesBaseForm;

public class RevisionDocumentacionForm extends SolicitudesBaseForm {

	private static final long serialVersionUID = 1L;

	private String idRevDoc = null;
	private String idUdoc = null;
	private String titulo = null;
	private String signaturaUdoc = null;
	private String expedienteUdoc = null;
	private int estado = 1;
	private Date fEstado = null;
	private String motivoRechazo = null;
	private String observaciones = null;
	private String idUsrGestor = null;
	private String idAlta = null;

	private String idRevDocSeleccionado[];
	private boolean ocultarMotivo = true;

	/**
	 * @return the idRevDoc
	 */
	public String getIdRevDoc() {
		return idRevDoc;
	}

	/**
	 * @param idRevDoc
	 *            the idRevDoc to set
	 */
	public void setIdRevDoc(String idRevDoc) {
		this.idRevDoc = idRevDoc;
	}

	/**
	 * @return the idUdoc
	 */
	public String getIdUdoc() {
		return idUdoc;
	}

	/**
	 * @param idUdoc
	 *            the idUdoc to set
	 */
	public void setIdUdoc(String idUdoc) {
		this.idUdoc = idUdoc;
	}

	/**
	 * @return the titulo
	 */
	public String getTitulo() {
		return titulo;
	}

	/**
	 * @param titulo
	 *            the titulo to set
	 */
	public void setTitulo(String titulo) {
		this.titulo = titulo;
	}

	/**
	 * @return the signaturaUdoc
	 */
	public String getSignaturaUdoc() {
		return signaturaUdoc;
	}

	/**
	 * @param signaturaUdoc
	 *            the signaturaUdoc to set
	 */
	public void setSignaturaUdoc(String signaturaUdoc) {
		this.signaturaUdoc = signaturaUdoc;
	}

	/**
	 * @return the expedienteUdoc
	 */
	public String getExpedienteUdoc() {
		return expedienteUdoc;
	}

	/**
	 * @param expedienteUdoc
	 *            the expedienteUdoc to set
	 */
	public void setExpedienteUdoc(String expedienteUdoc) {
		this.expedienteUdoc = expedienteUdoc;
	}

	/**
	 * @return the estado
	 */
	public int getEstado() {
		return estado;
	}

	/**
	 * @param estado
	 *            the estado to set
	 */
	public void setEstado(int estado) {
		this.estado = estado;
	}

	/**
	 * @return the fEstado
	 */
	public Date getFEstado() {
		return fEstado;
	}

	/**
	 * @param estado
	 *            the fEstado to set
	 */
	public void setFEstado(Date estado) {
		fEstado = estado;
	}

	/**
	 * @return the motivoRechazo
	 */
	public String getMotivoRechazo() {
		return motivoRechazo;
	}

	/**
	 * @param motivoRechazo
	 *            the motivoRechazo to set
	 */
	public void setMotivoRechazo(String motivoRechazo) {
		this.motivoRechazo = motivoRechazo;
	}

	/**
	 * @return the observaciones
	 */
	public String getObservaciones() {
		return observaciones;
	}

	/**
	 * @param observaciones
	 *            the observaciones to set
	 */
	public void setObservaciones(String observaciones) {
		this.observaciones = observaciones;
	}

	/**
	 * @return the idUsrGestor
	 */
	public String getIdUsrGestor() {
		return idUsrGestor;
	}

	/**
	 * @param idUsrGestor
	 *            the idUsrGestor to set
	 */
	public void setIdUsrGestor(String idUsrGestor) {
		this.idUsrGestor = idUsrGestor;
	}

	/**
	 * @return the idAlta
	 */
	public String getIdAlta() {
		return idAlta;
	}

	/**
	 * @param idAlta
	 *            the idAlta to set
	 */
	public void setIdAlta(String idAlta) {
		this.idAlta = idAlta;
	}

	/**
	 * @return the idRevDocSeleccionado
	 */
	public String[] getIdRevDocSeleccionado() {
		return idRevDocSeleccionado;
	}

	/**
	 * @param idRevDocSeleccionado
	 *            the idRevDocSeleccionado to set
	 */
	public void setIdRevDocSeleccionado(String[] idRevDocSeleccionado) {
		this.idRevDocSeleccionado = idRevDocSeleccionado;
	}

	/**
	 * @return the ocultarMotivo
	 */
	public boolean isOcultarMotivo() {
		return ocultarMotivo;
	}

	/**
	 * @param ocultarMotivo
	 *            the ocultarMotivo to set
	 */
	public void setOcultarMotivo(boolean ocultarMotivo) {
		this.ocultarMotivo = ocultarMotivo;
	}

	/**
	 * Reinicia lso valores del formulario
	 */
	public void reset() {
		this.idRevDoc = null;
		this.idUdoc = null;
		this.titulo = null;
		this.signaturaUdoc = null;
		this.expedienteUdoc = null;
		this.estado = 1;
		this.fEstado = null;
		this.motivoRechazo = null;
		this.observaciones = null;
		this.idUsrGestor = null;
		this.idAlta = null;
		this.idRevDocSeleccionado = null;
		this.ocultarMotivo = true;
	}
}