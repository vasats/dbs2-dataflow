package cz.uhk.fim.dbs2dataflow.model;

import jakarta.persistence.*;
import org.springframework.format.annotation.DateTimeFormat;

import java.time.LocalDateTime;

@Entity
@Table
public class ZaznamOPouziti {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ZaznamOPouzitiID")
    private Integer id;
    
    @ManyToOne
    @JoinColumn(name = "ZamestnanecID")
    private Zamestnanec zamestnanec;

    @ManyToOne
    @JoinColumn(name = "ZarizeniID")
    private Zarizeni zarizeni;
    @DateTimeFormat(pattern = "yyyy-MM-dd hh:mm:ss")
    private LocalDateTime datumCas;
}
