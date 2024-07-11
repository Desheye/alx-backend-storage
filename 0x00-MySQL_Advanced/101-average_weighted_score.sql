DELIMITER $$

CREATE PROCEDURE ComputeAverageWeightedScoreForUsers()
BEGIN
    DECLARE total_weighted_score DECIMAL(10, 2);
    DECLARE total_weight DECIMAL(10, 2);
    DECLARE avg_weighted_score DECIMAL(10, 2);

    -- Initialize variables
    SET total_weighted_score = 0;
    SET total_weight = 0;

    -- Calculate the total weighted score
    SELECT SUM(score * weight) INTO total_weighted_score
    FROM students;

    -- Calculate the total weight
    SELECT SUM(weight) INTO total_weight
    FROM students;

    -- Calculate the average weighted score
    IF total_weight > 0 THEN
        SET avg_weighted_score = total_weighted_score / total_weight;
    ELSE
        SET avg_weighted_score = 0;
    END IF;

    -- Store the result (you can modify this part as needed)
    INSERT INTO average_weighted_scores (average_score)
    VALUES (avg_weighted_score);
END $$

DELIMITER ;

