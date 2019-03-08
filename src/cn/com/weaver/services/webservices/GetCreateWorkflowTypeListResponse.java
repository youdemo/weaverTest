
package cn.com.weaver.services.webservices;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlType;
import weaver.workflow.webservices.ArrayOfWorkflowBaseInfo;

/**
 * <p>
 * Java class for anonymous complex type.
 * 
 * <p>
 * The following schema fragment specifies the expected content contained within
 * this class.
 * 
 * <pre>
 * &lt;complexType>
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="out" type="{http://webservices.workflow.weaver}ArrayOfWorkflowBaseInfo"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "", propOrder = { "out" })
@XmlRootElement(name = "getCreateWorkflowTypeListResponse")
public class GetCreateWorkflowTypeListResponse {

	@XmlElement(required = true, nillable = true)
	protected ArrayOfWorkflowBaseInfo out;

	/**
	 * Gets the value of the out property.
	 * 
	 * @return possible object is {@link ArrayOfWorkflowBaseInfo }
	 * 
	 */
	public ArrayOfWorkflowBaseInfo getOut() {
		return out;
	}

	/**
	 * Sets the value of the out property.
	 * 
	 * @param value
	 *            allowed object is {@link ArrayOfWorkflowBaseInfo }
	 * 
	 */
	public void setOut(ArrayOfWorkflowBaseInfo value) {
		this.out = value;
	}

}
