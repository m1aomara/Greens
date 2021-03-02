package com.example.OracleMongo.repository;

import com.example.OracleMongo.model.EnergyTracker;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;

import java.util.List;

@RepositoryRestResource(collectionResourceRel = "Tracker", path = "Tracker")
public interface TrackerRepository extends MongoRepository<EnergyTracker, String> {

    List<EnergyTracker> findAll();

}
