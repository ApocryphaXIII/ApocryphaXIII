import {
  Box,
  Button,
  LabeledList,
  NumberInput,
  Section,
  Stack,
} from 'tgui-core/components';

import { useBackend } from '../backend';
import { Window } from '../layouts';

export const Bepis = (props) => {
  const { act, data } = useBackend();
  const { amount } = data;
  return (
    <Window width={500} height={480}>
      <Window.Content>
        <Section title="Business Exploration Protocol Incubation Sink">
          <Section
            title="Information"
            backgroundColor="#450F44"
            buttons={
              <Button
                icon="power-off"
                content={data.manual_power ? 'Off' : 'On'}
                selected={!data.manual_power}
                onClick={() => act('toggle_power')}
              />
            }
          >
            All you need to know about the B.E.P.I.S. and you! The B.E.P.I.S.
            performs hundreds of tests a second using electrical and financial
            resources to invent new products, or discover new technologies
            otherwise overlooked for being too risky or too niche to produce!
          </Section>
          <Section
            title="Payer's Account"
            buttons={
              <Button
                icon="redo-alt"
                content="Reset Account"
                onClick={() => act('account_reset')}
              />
            }
          >
            Console is currently being operated by{' '}
            {data.account_holder ? data.account_holder : 'no one'}.
          </Section>
          <Stack>
            <Stack.Item basis="60%">
              <Section title="Stored Data and Statistics">
                <LabeledList>
                  <LabeledList.Item label="Deposited Credits">
                    {data.stored_cash}
                  </LabeledList.Item>
                  <LabeledList.Item label="Investment Variability">
                    {data.accuracy_percentage}%
                  </LabeledList.Item>
                  <LabeledList.Item label="Innovation Bonus">
                    {data.positive_cash_offset}
                  </LabeledList.Item>
                  <LabeledList.Item label="Risk Offset" color="bad">
                    {data.negative_cash_offset}
                  </LabeledList.Item>
                  <LabeledList.Item label="Deposit Amount">
                    <NumberInput
                      value={amount}
                      unit="Credits"
                      minValue={100}
                      maxValue={30000}
                      step={100}
                      stepPixelSize={2}
                      onChange={(e, value) =>
                        act('amount', {
                          amount: value,
                        })
                      }
                    />
                  </LabeledList.Item>
                </LabeledList>
              </Section>
              <Box>
                <Button
                  icon="donate"
                  content="Deposit Credits"
                  disabled={data.manual_power === 1 || data.silicon_check === 1}
                  onClick={() => act('deposit_cash')}
                />
                <Button
                  icon="eject"
                  content="Withdraw Credits"
                  disabled={data.manual_power === 1}
                  onClick={() => act('withdraw_cash')}
                />
              </Box>
            </Stack.Item>
            <Stack.Item>
              <Section title="Market Data and Analysis">
                <Box>Average technology cost: {data.mean_value}</Box>
                <Box>
                  Current chance of Success: Est. {data.success_estimate}%
                </Box>
                {data.error_name && (
                  <Box color="bad">
                    Previous Failure Reason: Deposited cash value too low.
                    Please insert more money for future success.
                  </Box>
                )}
                <Box m={1} />
                <Button
                  icon="microscope"
                  disabled={data.manual_power === 1}
                  onClick={() => act('begin_experiment')}
                  content="Begin Testing"
                />
              </Section>
            </Stack.Item>
          </Stack>
        </Section>
      </Window.Content>
    </Window>
  );
};
