/**
 * JwsServiceHelloServiceLocator.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package com.nan.test;

public class JwsServiceHelloServiceLocator extends org.apache.axis.client.Service implements com.nan.test.JwsServiceHelloService {

    public JwsServiceHelloServiceLocator() {
    }


    public JwsServiceHelloServiceLocator(org.apache.axis.EngineConfiguration config) {
        super(config);
    }

    public JwsServiceHelloServiceLocator(java.lang.String wsdlLoc, javax.xml.namespace.QName sName) throws javax.xml.rpc.ServiceException {
        super(wsdlLoc, sName);
    }

    // Use to get a proxy class for JwsServiceHelloPort
    private java.lang.String JwsServiceHelloPort_address = "http://localhost:8080/Service/ServiceHello";

    public java.lang.String getJwsServiceHelloPortAddress() {
        return JwsServiceHelloPort_address;
    }

    // The WSDD service name defaults to the port name.
    private java.lang.String JwsServiceHelloPortWSDDServiceName = "JwsServiceHelloPort";

    public java.lang.String getJwsServiceHelloPortWSDDServiceName() {
        return JwsServiceHelloPortWSDDServiceName;
    }

    public void setJwsServiceHelloPortWSDDServiceName(java.lang.String name) {
        JwsServiceHelloPortWSDDServiceName = name;
    }

    public com.nan.test.JwsServiceHello getJwsServiceHelloPort() throws javax.xml.rpc.ServiceException {
       java.net.URL endpoint;
        try {
            endpoint = new java.net.URL(JwsServiceHelloPort_address);
        }
        catch (java.net.MalformedURLException e) {
            throw new javax.xml.rpc.ServiceException(e);
        }
        return getJwsServiceHelloPort(endpoint);
    }

    public com.nan.test.JwsServiceHello getJwsServiceHelloPort(java.net.URL portAddress) throws javax.xml.rpc.ServiceException {
        try {
            com.nan.test.JwsServiceHelloPortBindingStub _stub = new com.nan.test.JwsServiceHelloPortBindingStub(portAddress, this);
            _stub.setPortName(getJwsServiceHelloPortWSDDServiceName());
            return _stub;
        }
        catch (org.apache.axis.AxisFault e) {
            return null;
        }
    }

    public void setJwsServiceHelloPortEndpointAddress(java.lang.String address) {
        JwsServiceHelloPort_address = address;
    }

    /**
     * For the given interface, get the stub implementation.
     * If this service has no port for the given interface,
     * then ServiceException is thrown.
     */
    public java.rmi.Remote getPort(Class serviceEndpointInterface) throws javax.xml.rpc.ServiceException {
        try {
            if (com.nan.test.JwsServiceHello.class.isAssignableFrom(serviceEndpointInterface)) {
                com.nan.test.JwsServiceHelloPortBindingStub _stub = new com.nan.test.JwsServiceHelloPortBindingStub(new java.net.URL(JwsServiceHelloPort_address), this);
                _stub.setPortName(getJwsServiceHelloPortWSDDServiceName());
                return _stub;
            }
        }
        catch (java.lang.Throwable t) {
            throw new javax.xml.rpc.ServiceException(t);
        }
        throw new javax.xml.rpc.ServiceException("There is no stub implementation for the interface:  " + (serviceEndpointInterface == null ? "null" : serviceEndpointInterface.getName()));
    }

    /**
     * For the given interface, get the stub implementation.
     * If this service has no port for the given interface,
     * then ServiceException is thrown.
     */
    public java.rmi.Remote getPort(javax.xml.namespace.QName portName, Class serviceEndpointInterface) throws javax.xml.rpc.ServiceException {
        if (portName == null) {
            return getPort(serviceEndpointInterface);
        }
        java.lang.String inputPortName = portName.getLocalPart();
        if ("JwsServiceHelloPort".equals(inputPortName)) {
            return getJwsServiceHelloPort();
        }
        else  {
            java.rmi.Remote _stub = getPort(serviceEndpointInterface);
            ((org.apache.axis.client.Stub) _stub).setPortName(portName);
            return _stub;
        }
    }

    public javax.xml.namespace.QName getServiceName() {
        return new javax.xml.namespace.QName("http://test.nan.com/", "JwsServiceHelloService");
    }

    private java.util.HashSet ports = null;

    public java.util.Iterator getPorts() {
        if (ports == null) {
            ports = new java.util.HashSet();
            ports.add(new javax.xml.namespace.QName("http://test.nan.com/", "JwsServiceHelloPort"));
        }
        return ports.iterator();
    }

    /**
    * Set the endpoint address for the specified port name.
    */
    public void setEndpointAddress(java.lang.String portName, java.lang.String address) throws javax.xml.rpc.ServiceException {
        
if ("JwsServiceHelloPort".equals(portName)) {
            setJwsServiceHelloPortEndpointAddress(address);
        }
        else 
{ // Unknown Port Name
            throw new javax.xml.rpc.ServiceException(" Cannot set Endpoint Address for Unknown Port" + portName);
        }
    }

    /**
    * Set the endpoint address for the specified port name.
    */
    public void setEndpointAddress(javax.xml.namespace.QName portName, java.lang.String address) throws javax.xml.rpc.ServiceException {
        setEndpointAddress(portName.getLocalPart(), address);
    }

}
