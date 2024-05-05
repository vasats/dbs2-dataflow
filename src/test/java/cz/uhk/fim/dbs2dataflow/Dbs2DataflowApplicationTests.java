package cz.uhk.fim.dbs2dataflow;

import cz.uhk.fim.dbs2dataflow.model.Adresa;
import cz.uhk.fim.dbs2dataflow.model.Zamestnanec;
import cz.uhk.fim.dbs2dataflow.repository.ZamestnanecRepository;
import cz.uhk.fim.dbs2dataflow.service.ZamestnanecService;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import static org.junit.jupiter.api.Assertions.*;

@ExtendWith(MockitoExtension.class)
class Dbs2DataflowApplicationTests {

    @Mock
    private ZamestnanecRepository repository;

    @InjectMocks
    ZamestnanecService zamestnanecService;
    Zamestnanec zamestnanec = new Zamestnanec();
    Adresa adresa = new Adresa();

    @BeforeEach
    void setup(){
        zamestnanec.setId(null);
        zamestnanec.setEmail("email@email.com");
        zamestnanec.setJmeno("Thomas");
        zamestnanec.setPrijmeni("Smith");
        zamestnanec.setRodneCislo("213548/4565");
        zamestnanec.setTelefon("213 225 625");
        zamestnanec.setAdresa(adresa);
        adresa.setId(null);
        adresa.setPsc("551 01");
        adresa.setUlice("Hradecká");
        adresa.setCisloPopisne("254");
    }

    @Test
    void invalidEmail() {
        zamestnanec.setEmail("invalidEmailAddress");
        Exception e = assertThrows(IllegalArgumentException.class,() -> zamestnanecService.insertZamestnanecAdresa(adresa,zamestnanec));
        assertEquals("illegal email",e.getMessage());
    }
    @Test
    void validInput() {
        assertDoesNotThrow(()->zamestnanecService.insertZamestnanecAdresa(adresa,zamestnanec));
    }
    @Test
    void invalidPsc() {
        adresa.setPsc("invalidPsc");
        Exception e = assertThrows(IllegalArgumentException.class,() -> zamestnanecService.insertZamestnanecAdresa(adresa,zamestnanec));
        assertEquals("illegal psc",e.getMessage());
    }
    @Test
    void blankUlice() {
        adresa.setUlice("  ");
        Exception e = assertThrows(IllegalArgumentException.class,() -> zamestnanecService.insertZamestnanecAdresa(adresa,zamestnanec));
        assertEquals("ulice is blank",e.getMessage());
    }
    @Test
    void invalidRodnecislo() {
        zamestnanec.setRodneCislo("12345/6415");
        Exception e = assertThrows(IllegalArgumentException.class,() -> zamestnanecService.insertZamestnanecAdresa(adresa,zamestnanec));
        assertEquals("illegal rodne cislo",e.getMessage());
    }

}
