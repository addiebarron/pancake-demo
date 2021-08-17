export async function get({ params }) {
  const { zip } = params;
  const res = await fetch(`http://server:3000/tests?zip=eq.${zip}`);
  const data = await res.json();

  return { body: data };
}
