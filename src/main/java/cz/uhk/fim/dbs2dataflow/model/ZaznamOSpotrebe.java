package cz.uhk.fim.dbs2dataflow.model;

import jakarta.persistence.*;
import org.springframework.format.annotation.DateTimeFormat;

import java.time.LocalDateTime;

@Entity
@Table(name = "Zaznamospotrebe")
public class ZaznamOSpotrebe {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer zaznamOSpotrebeID;
    private Float spotreba;
    @DateTimeFormat(pattern = "yyyy-MM-dd hh:mm:ss")
    private LocalDateTime datumcas;
    @ManyToOne
    @JoinColumn(name = "ZarizeniID")
    private Zarizeni zarizeni;
    
    
    
}
