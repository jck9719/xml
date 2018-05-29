import java.io.File;
import java.io.FileOutputStream;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.DocumentBuilder;

import org.w3c.dom.*;
import org.w3c.dom.bootstrap.DOMImplementationRegistry;
import org.w3c.dom.ls.LSOutput;
import org.w3c.dom.ls.LSSerializer;
import org.w3c.dom.ls.DOMImplementationLS;
import org.w3c.dom.ls.LSParser;


/*
1. getElementsByTagName
2. cloneNode
3. getNodeType
4. getAttribute
5. setAttribute
6. removeAttribute
7. getBaseURI
8. normalize
9. hasAttribute
10. hasAttributes
11. getNodeName
 */

public class Dom3 {
    public static void main(String[] args) {
        try {
            File inputFile = new File(args[0]);
            DOMImplementationRegistry registry = DOMImplementationRegistry.newInstance();
            DOMImplementationLS impl = (DOMImplementationLS) registry.getDOMImplementation("LS");
            LSParser builder = impl.createLSParser(DOMImplementationLS.MODE_SYNCHRONOUS, null);
            DOMConfiguration config = builder.getDomConfig();

            DocumentBuilderFactory dbFactory
                    = DocumentBuilderFactory.newInstance();
            DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
            Document doc = dBuilder.parse(inputFile);
            doc.getDocumentElement().normalize();

            System.out.println("Root :" + doc.getDocumentElement().getNodeName());
            System.out.println("Ścieżka do pliku: " + doc.getBaseURI());
            NodeList nList = doc.getElementsByTagName("lek");


            System.out.println("----------------------------");
            for (int i = 0; i < nList.getLength(); i++) {
                Node nNode = nList.item(i);
                Node exampleNode = nNode.cloneNode(true);

                System.out.println("\nElement: "
                        + nNode.getNodeName());
                if (nNode.getNodeType() == Node.ELEMENT_NODE) {
                    Element eElement = (Element) nNode;



                    System.out.println("Cloned element name: " + exampleNode.getNodeName());


                    System.out.println("Czy lek jest na NFZ? " + eElement.getAttribute("nfz"));
                    if(eElement.getAttribute("nfz").equals("tak")) {
                        System.out.println("Usuwanie dofinansowania NFZ... ");
                        eElement.setAttribute("nfz", "nie");
                        System.out.println("Czy lek jest na NFZ?: "
                                + eElement.getAttribute("nfz"));
                    }

                    System.out.println("Nazwa: "
                            + eElement
                            .getElementsByTagName("nazwa")
                            .item(0)
                            .getTextContent());

                    System.out.println("Producent: "
                            + eElement
                            .getElementsByTagName("producent")
                            .item(0)
                            .getTextContent());

                    System.out.println("Substancja czynna: "
                            + eElement
                            .getElementsByTagName("substancja_czynna")
                            .item(0)
                            .getTextContent());

                    System.out.println("Cena: "
                            + eElement
                            .getElementsByTagName("cena")
                            .item(0)
                            .getTextContent());

                }
            }


                System.out.println("\nUsuwanie atrybutu NFZ!!!\n");



            for(int i=0; i<nList.getLength(); i++) {
                Node sNode = nList.item(i);
                Element eEelement = (Element) sNode;
                eEelement.removeAttribute("nfz");

                if(!(eEelement.hasAttribute("nfz")  || eEelement.hasAttributes()))
                    System.out.println("ATRYBUT NFZ DLA LEKU " + eEelement.getElementsByTagName("nazwa").item(0).getTextContent() + " USUNIĘTY");

                else
                    System.out.println("Oops, something went wrong");
            }




            LSSerializer domWriter = impl.createLSSerializer();
            config = domWriter.getDomConfig();
            config.setParameter("xml-declaration", Boolean.TRUE);
            config.setParameter("format-pretty-print", Boolean.TRUE);

            LSOutput dOut = impl.createLSOutput();
            dOut.setByteStream(new FileOutputStream(args[1]));

            domWriter.write(doc, dOut);


        } catch (Exception e) {
            e.printStackTrace();
        }


    }
}
