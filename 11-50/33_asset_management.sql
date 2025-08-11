SELECT a.name, u.name AS current_user
FROM assets a
JOIN assignments asn ON a.id = asn.asset_id
JOIN users u ON asn.user_id = u.id
WHERE asn.returned_date IS NULL;
SELECT a.*
FROM assets a
WHERE a.id NOT IN (
    SELECT asset_id FROM assignments WHERE returned_date IS NULL
);
