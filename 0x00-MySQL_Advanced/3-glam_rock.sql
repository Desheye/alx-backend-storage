-- Retrieves a list of bands whose main style is Glam rock, ordered by their longevity.
SELECT band_name,
    (IFNULL(split, '2020') - formed) AS lifespan
FROM metal_bands
WHERE FIND_IN_SET('Glam rock', IFNULL(style, "")) > 0
ORDER BY lifespan DESC;

