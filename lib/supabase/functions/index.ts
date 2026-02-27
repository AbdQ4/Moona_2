import Stripe from "https://esm.sh/stripe@13.0.0?target=deno";


const stripe = new Stripe(Deno.env.get("STRIPE_SECRET_KEY")!, {
  apiVersion: "2023-10-16",
});

Deno.serve(async (req) => {
  const { amount, supplierAccountId } = await req.json();

  const paymentIntent = await stripe.paymentIntents.create({
    amount: amount,Deno: Initialize Workspace Configuration
    currency: "aed",
    application_fee_amount: Math.floor(amount * 0.10),
    transfer_data: {
      destination: supplierAccountId,
    },
  });

  return new Response(
    JSON.stringify({ clientSecret: paymentIntent.client_secret }),
    { headers: { "Content-Type": "application/json" } }
  );
});
